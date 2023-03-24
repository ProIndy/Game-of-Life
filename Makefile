# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ijaaskel <ijaaskel@student.hive.fi>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/23 16:30:08 by ijaaskel          #+#    #+#              #
#    Updated: 2022/06/23 16:30:17 by ijaaskel         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


NAME	=	life

FLAGS	=	-Wall -Wextra
O_FLAGS	=	-O3

SRC		=	./src/
SRCS	=	main.c	life.c	read.c	play.c	print.c visualizer.c
OBJS	=	$(SRCS:.c=.o)

ifneq (,$(wildcard /usr/local/include/mlx.h))
MLX			=	-I /usr/local/include
else
MLX			=	-I /usr/X11/include
endif

ifneq (,$(wildcard /usr/local/lib/libmlx.a))
MLX			+=	-L /usr/local/lib -lmlx
else ifneq (,$(wildcard /usr/local/lib/libmlx.dylib))
MLX			+=	-L /usr/local/lib -lmlx
else
MLX			+=	-L /usr/X11/lib -lmlx
endif

UNAME		:=	$(shell uname -s)
ifeq ($(UNAME), Darwin)
FRAMEWORKS	=	-framework OpenGL -framework AppKit
endif
ifeq ($(UNAME), Linux)
MLX			+=	-lX11 -lXext
endif

all:	$(NAME)

$(NAME):
	gcc $(O_FLAGS) $(FLAGS) $(MLX) -c $(addprefix $(SRC), $(SRCS))
	gcc -o $(NAME) $(OBJS) $(MLX) $(FRAMEWORKS)

clean:
	rm -v -f $(OBJS)
	rm -v -f *~

fclean:	clean
	rm -v -f $(NAME)

re:		fclean all

.PHONY:	all clean fclean re
