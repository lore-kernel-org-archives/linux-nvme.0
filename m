From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 9 Nov 2017 18:04:57 +0200
Subject: kernel 4.14 how to install Mellanox connectx-3 infiniband driver?
In-Reply-To: <CADL4p-r918miLJZeOviG5+OUeYGwML65SpuEwZ8=AmfNkUHHMQ@mail.gmail.com>
References: <CADL4p-rRJ6ydSuYBsjUOOE88ZUF5g_akY5Eb-bnA4ZsodhLEDQ@mail.gmail.com>
 <CADL4p-r918miLJZeOviG5+OUeYGwML65SpuEwZ8=AmfNkUHHMQ@mail.gmail.com>
Message-ID: <d98b15f1-99a8-1e19-efa6-0f7f15fd9116@grimberg.me>

Hi Tony,

> Hi, All
>     I downloaded the nvme with multipath kernel, The kernel version is
> 4.14, I encountered a problem, I use Mellanox connectx-3 infiniband
> driver. Because the 4.14 kernel version is too new to install
> infiniband driver, does anyone encounter with me The same situation?
> How to solve? Thank you for your help.

Is there any reason why you're using Mellanox out-of-tree driver?
I'm pretty sure nvme-rdma will work just fine with the in-kernel
mlx4 driver (unless you need some other functionality that does not
exist in 4.14).
