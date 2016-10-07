From: j.naumann@fu-berlin.de (Jan Luca Naumann)
Date: Fri, 7 Oct 2016 12:06:48 +0200
Subject: Problem with new uapi header in Linux kernel 4.4+
In-Reply-To: <20161007072923.GA1936@infradead.org>
References: <37b9f516-a945-d41f-b21a-48728d7f9680@fu-berlin.de>
 <20161006230947.GA3696@localhost.localdomain>
 <20161007072923.GA1936@infradead.org>
Message-ID: <a96a5e01-b6b2-b867-4fa8-12da56f6c17d@fu-berlin.de>

Hey,

the license issue was the reason I'm looking for a better solution than
just copy the relevant parts from the nvme.h file.

Best regards,
Jan

Am 07.10.2016 um 09:29 schrieb Christoph Hellwig:
> On Thu, Oct 06, 2016@07:09:48PM -0400, Keith Busch wrote:
>> Yeah, we changed the uapi to only contain the what's necessary for the
>> user-kernel interface. We don't want user space to depend on the kernel
>> header for structure definitions when the kernel has no use for some them.
>>
>> For the nvme-cli project, we define everything. I'm up for turning parts
>> of this into a shared library that sedutil and others can use.
> 
> FYI, one issue is the the Linux nvme.h is GPLv2 only like much of the
> kernel, making it hard to use for things like sedutils that use GPLv3+.
> I'd be fine with relicing my contributions to it under GPLv2+, but I
> don't sign up for contacting everyone that ever touched it and get
> their permission..
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20161007/385ead8c/attachment.sig>
