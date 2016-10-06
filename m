From: keith.busch@intel.com (Keith Busch)
Date: Thu, 6 Oct 2016 19:09:48 -0400
Subject: Problem with new uapi header in Linux kernel 4.4+
In-Reply-To: <37b9f516-a945-d41f-b21a-48728d7f9680@fu-berlin.de>
References: <37b9f516-a945-d41f-b21a-48728d7f9680@fu-berlin.de>
Message-ID: <20161006230947.GA3696@localhost.localdomain>

On Thu, Oct 06, 2016@05:15:04PM +0200, Jan Luca Naumann wrote:
> Hey,
> 
> at the moment I try to install a tool called "sedutil"[1]. The tool
> manages self encrypting drives that conform to the TCG OPAL 2.0
> specification.
> 
> The program uses in the current version i.a. ioctl() to communicate with
> NVMe disks (see header [2] and source file [3]). The problem is that the
> tool uses the no longer to the user space exported header file
> "linux/nvme.h". In the new uapi header "linux/nvme_ioctl.h" are the
> enumeration "nvme_admin_opcode" and the structure "nvme_id_ctrl" no
> longer available that are used in the source code...
> 
> Since I do not have much experience with ioctl/NVMe and the upstream
> author has no time at the moment, I want to ask you what would be the
> best attempt to fix this.

Yeah, we changed the uapi to only contain the what's necessary for the
user-kernel interface. We don't want user space to depend on the kernel
header for structure definitions when the kernel has no use for some them.

For the nvme-cli project, we define everything. I'm up for turning parts
of this into a shared library that sedutil and others can use.
