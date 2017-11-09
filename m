From: xjtuwjp@gmail.com (Jack Wang)
Date: Thu, 9 Nov 2017 17:09:01 +0100
Subject: kernel 4.14 how to install Mellanox connectx-3 infiniband driver?
In-Reply-To: <CADL4p-r918miLJZeOviG5+OUeYGwML65SpuEwZ8=AmfNkUHHMQ@mail.gmail.com>
References: <CADL4p-rRJ6ydSuYBsjUOOE88ZUF5g_akY5Eb-bnA4ZsodhLEDQ@mail.gmail.com>
 <CADL4p-r918miLJZeOviG5+OUeYGwML65SpuEwZ8=AmfNkUHHMQ@mail.gmail.com>
Message-ID: <CAD+HZHVtXozfiQ2_gs4b5XHLveye+YUwkBMFNi7nWeLui9J2-A@mail.gmail.com>

Tony,

2017-11-09 16:20 GMT+01:00 Tony Yang <yyt168 at gmail.com>:
> Hi, All
>    I downloaded the nvme with multipath kernel, The kernel version is
> 4.14, I encountered a problem, I use Mellanox connectx-3 infiniband
> driver. Because the 4.14 kernel version is too new to install
> infiniband driver, does anyone encounter with me The same situation?
> How to solve? Thank you for your help.
>
As Sagi also said, there is driver in tree.

You need build you kernel with CONFIG_MLX4_INFINIBAND enabled.

Jack
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
