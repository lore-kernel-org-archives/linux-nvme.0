From: dongli.zhang@oracle.com (Dongli Zhang)
Date: Mon, 8 Oct 2018 13:59:05 +0800
Subject: nvme-pci: number of queues off by one
In-Reply-To: <CAF6hzxwN4S4C37dbdARcW+tgLMRjvHtzOZjFomVQBVntshZ+7w@mail.gmail.com>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de> <20180301150329.GB6795@ming.t460p>
 <20180301161042.GA14799@localhost.localdomain>
 <20180308074220.GC15748@lst.de>
 <20180309172445.GC14765@localhost.localdomain>
 <20180312090827.GB23903@ming.t460p>
 <CAF6hzxwN4S4C37dbdARcW+tgLMRjvHtzOZjFomVQBVntshZ+7w@mail.gmail.com>
Message-ID: <9c851b95-1c41-2171-40ec-bd47032401fc@oracle.com>

I can reproduce with qemu:

# ls /sys/block/nvme*n1/mq/*/cpu_list
/sys/block/nvme0n1/mq/0/cpu_list
/sys/block/nvme0n1/mq/1/cpu_list
/sys/block/nvme0n1/mq/2/cpu_list
/sys/block/nvme0n1/mq/3/cpu_list
/sys/block/nvme0n1/mq/4/cpu_list
/sys/block/nvme0n1/mq/5/cpu_list
/sys/block/nvme0n1/mq/6/cpu_list

Here is the qemu cmdline emulating 8-queue nvme while the VM has 12 cpu:

# qemu-system-x86_64 -m 4096 -smp 12 \
	-kernel /path-to-kernel/linux-4.18.10/arch/x86_64/boot/bzImage \
	-hda /path-to-img/ubuntu1804.qcow2  \
	-append "root=/dev/sda1 init=/sbin/init text" -enable-kvm \
	-net nic -net user,hostfwd=tcp::5022-:22 \
	-device nvme,drive=nvme1,serial=deadbeaf1,num_queues=8 \
	-drive file=/path-to-img/nvme.disk,if=none,id=nvme1

Dongli Zhang


On 10/08/2018 01:05 PM, Prasun Ratn wrote:
> Hi
> 
> I have an NVMe SSD that has 8 hw queues and on older kernels I see all
> 8 show up. However on a recent kernel (I tried 4.18), I only see 7. Is
> this a known issue?
> 
> $ uname -r
> 4.14.1-1.el7.elrepo.x86_64
> 
> $ ls /sys/block/nvme*n1/mq/*/cpu_list
> /sys/block/nvme0n1/mq/0/cpu_list
> /sys/block/nvme0n1/mq/1/cpu_list
> /sys/block/nvme0n1/mq/2/cpu_list
> /sys/block/nvme0n1/mq/3/cpu_list
> /sys/block/nvme0n1/mq/4/cpu_list
> /sys/block/nvme0n1/mq/5/cpu_list
> /sys/block/nvme0n1/mq/6/cpu_list
> /sys/block/nvme0n1/mq/7/cpu_list
> /sys/block/nvme1n1/mq/0/cpu_list
> /sys/block/nvme1n1/mq/1/cpu_list
> /sys/block/nvme1n1/mq/2/cpu_list
> /sys/block/nvme1n1/mq/3/cpu_list
> /sys/block/nvme1n1/mq/4/cpu_list
> /sys/block/nvme1n1/mq/5/cpu_list
> /sys/block/nvme1n1/mq/6/cpu_list
> /sys/block/nvme1n1/mq/7/cpu_list
> /sys/block/nvme2n1/mq/0/cpu_list
> /sys/block/nvme2n1/mq/1/cpu_list
> /sys/block/nvme2n1/mq/2/cpu_list
> /sys/block/nvme2n1/mq/3/cpu_list
> /sys/block/nvme2n1/mq/4/cpu_list
> /sys/block/nvme2n1/mq/5/cpu_list
> /sys/block/nvme2n1/mq/6/cpu_list
> /sys/block/nvme2n1/mq/7/cpu_list
> /sys/block/nvme3n1/mq/0/cpu_list
> /sys/block/nvme3n1/mq/1/cpu_list
> /sys/block/nvme3n1/mq/2/cpu_list
> /sys/block/nvme3n1/mq/3/cpu_list
> /sys/block/nvme3n1/mq/4/cpu_list
> /sys/block/nvme3n1/mq/5/cpu_list
> /sys/block/nvme3n1/mq/6/cpu_list
> /sys/block/nvme3n1/mq/7/cpu_list
> 
> 
> $ uname -r
> 4.18.10-1.el7.elrepo.x86_64
> 
> $ ls /sys/block/nvme*n1/mq/*/cpu_list
> /sys/block/nvme0n1/mq/0/cpu_list
> /sys/block/nvme0n1/mq/1/cpu_list
> /sys/block/nvme0n1/mq/2/cpu_list
> /sys/block/nvme0n1/mq/3/cpu_list
> /sys/block/nvme0n1/mq/4/cpu_list
> /sys/block/nvme0n1/mq/5/cpu_list
> /sys/block/nvme0n1/mq/6/cpu_list
> /sys/block/nvme1n1/mq/0/cpu_list
> /sys/block/nvme1n1/mq/1/cpu_list
> /sys/block/nvme1n1/mq/2/cpu_list
> /sys/block/nvme1n1/mq/3/cpu_list
> /sys/block/nvme1n1/mq/4/cpu_list
> /sys/block/nvme1n1/mq/5/cpu_list
> /sys/block/nvme1n1/mq/6/cpu_list
> /sys/block/nvme2n1/mq/0/cpu_list
> /sys/block/nvme2n1/mq/1/cpu_list
> /sys/block/nvme2n1/mq/2/cpu_list
> /sys/block/nvme2n1/mq/3/cpu_list
> /sys/block/nvme2n1/mq/4/cpu_list
> /sys/block/nvme2n1/mq/5/cpu_list
> /sys/block/nvme2n1/mq/6/cpu_list
> /sys/block/nvme3n1/mq/0/cpu_list
> /sys/block/nvme3n1/mq/1/cpu_list
> /sys/block/nvme3n1/mq/2/cpu_list
> /sys/block/nvme3n1/mq/3/cpu_list
> /sys/block/nvme3n1/mq/4/cpu_list
> /sys/block/nvme3n1/mq/5/cpu_list
> /sys/block/nvme3n1/mq/6/cpu_list
> 
