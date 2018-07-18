From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 18 Jul 2018 17:12:11 -0600
Subject: nvme-cli shows failed to map on Kernel 4.16.16
In-Reply-To: <CAGSHeY1JpRAXzbdYKpwVnB5Wug=6iyUZVUqLteQCgOOEqq5RoA@mail.gmail.com>
References: <CAGSHeY1JpRAXzbdYKpwVnB5Wug=6iyUZVUqLteQCgOOEqq5RoA@mail.gmail.com>
Message-ID: <20180718231211.GE32160@localhost.localdomain>

On Wed, Jul 18, 2018@04:08:43PM -0700, Yogi Wannabe wrote:
> Hi all,
> 
> I downloaded the latest nvme-cli-master and ran the following command
> on a Centos 7.4 with kernel 3.19.8. The command worked fine
> 
> ./nvme list /dev/nvme0n1
> 
> I ran the same command on a Debian 9.5 with Kernel 4.16.16 and I got
> the error msg "failed to map". Googling led me to this link
> https://github.com/linux-nvme/nvme-cli/issues/81
> 
> I checked the kernel configuration on 4.16.16 and I see this setting:
> CONFIG_IO_STRICT_DEVMEM=y
> 
> Does this mean that nvme list won't work until I rebuild the kernel
> with CONFIG_IO_STRICT_DEVMEM=n?

That is correct, you will not be able to use that command when
CONFIG_IO_STRICT_DEVMEM=y. When that kernel config option is set, the
kernel will not allow user space to mmap io memory if a driver also
mapped it.
