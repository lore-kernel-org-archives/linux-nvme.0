From: keith.busch@intel.com (Keith Busch)
Date: Sat, 20 Jan 2018 19:50:31 -0700
Subject: Hang when running LLVM+clang test suite
In-Reply-To: <7F6A25BD-AA87-4800-886F-1A256FFD8967@znu.io>
References: <7F6A25BD-AA87-4800-886F-1A256FFD8967@znu.io>
Message-ID: <20180121025030.GK12043@localhost.localdomain>

On Sat, Jan 20, 2018@05:47:06AM -0500, David Zarzycki wrote:
> Hello NVMe developers,
> 
> The LLVM+clang the test suite regularly (but not reliably) hangs the kernel (version 4.14.13-300.fc27.x86_64). I don?t see this hang when running the test suite in /tmp (tmpfs) or on a SATA SSD.
> 
> Here are photos of the console debug info, with the NVMe driver in the backtrace:
> 
> http://znu.io/dual8168hang.tar
> 
> Here is another instance of the hang, again with NVMe in the backtrace:
> 
> http://znu.io/IMG_0362.jpg

It looks like the scheduler is stuck or a task struct is corrupt. I can't
think of anything off the top of my head what nvme has to do with that,
though. It just invokes the callback associated with a command and
doesn't directly manipulate any scheduler structs.
