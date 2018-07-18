From: yogi43222@gmail.com (Yogi Wannabe)
Date: Wed, 18 Jul 2018 16:08:43 -0700
Subject: nvme-cli shows failed to map on Kernel 4.16.16
Message-ID: <CAGSHeY1JpRAXzbdYKpwVnB5Wug=6iyUZVUqLteQCgOOEqq5RoA@mail.gmail.com>

Hi all,

I downloaded the latest nvme-cli-master and ran the following command
on a Centos 7.4 with kernel 3.19.8. The command worked fine

./nvme list /dev/nvme0n1

I ran the same command on a Debian 9.5 with Kernel 4.16.16 and I got
the error msg "failed to map". Googling led me to this link
https://github.com/linux-nvme/nvme-cli/issues/81

I checked the kernel configuration on 4.16.16 and I see this setting:
CONFIG_IO_STRICT_DEVMEM=y

Does this mean that nvme list won't work until I rebuild the kernel
with CONFIG_IO_STRICT_DEVMEM=n?

thanks
