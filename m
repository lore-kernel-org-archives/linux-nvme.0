From: dave@znu.io (David Zarzycki)
Date: Sun, 21 Jan 2018 08:49:26 -0500
Subject: Hang when running LLVM+clang test suite
In-Reply-To: <20180121025030.GK12043@localhost.localdomain>
References: <7F6A25BD-AA87-4800-886F-1A256FFD8967@znu.io>
 <20180121025030.GK12043@localhost.localdomain>
Message-ID: <21BE2F60-44C9-41E9-B64F-05C90008D44F@znu.io>



> On Jan 20, 2018,@21:50, Keith Busch <keith.busch@intel.com> wrote:
> 
> On Sat, Jan 20, 2018@05:47:06AM -0500, David Zarzycki wrote:
>> Hello NVMe developers,
>> 
>> The LLVM+clang the test suite regularly (but not reliably) hangs the kernel (version 4.14.13-300.fc27.x86_64). I don?t see this hang when running the test suite in /tmp (tmpfs) or on a SATA SSD.
>> 
>> Here are photos of the console debug info, with the NVMe driver in the backtrace:
>> 
>> http://znu.io/dual8168hang.tar
>> 
>> Here is another instance of the hang, again with NVMe in the backtrace:
>> 
>> http://znu.io/IMG_0362.jpg
> 
> It looks like the scheduler is stuck or a task struct is corrupt. I can't
> think of anything off the top of my head what nvme has to do with that,
> though. It just invokes the callback associated with a command and
> doesn't directly manipulate any scheduler structs.

Hi Keith,

Thanks for looking at the backtraces. What other subsystems should I be looking at then?

Given that the LLVM+clang test suite is reliable when built/run in tmpfs, that implies that most of the kernel is reliable. I?ve also run the test suite reliably on an ext4 filesystem on a SATA SSD.

I?ve tried both xfs and ext4 on NVMe and they both crash, which implies that individual filesystems aren't the problem. Please note that the NVMe setup is simple: one partition and no LVM, RAID, bcache, etc.

What?s left at this point? What other combinations or debug parameters should I test?

Thanks for any help you can give,
Dave
