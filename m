From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 24 Jan 2018 21:55:20 +0900
Subject: [PATCH 0/2] nvme-cli: add support for an abort command with
 documentation
In-Reply-To: <20180124123141.t4gtx6fvzgei2rei@linux-x5ow.site>
References: <1516796682-31793-1-git-send-email-minwoo.im.dev@gmail.com>
 <20180124123141.t4gtx6fvzgei2rei@linux-x5ow.site>
Message-ID: <98552e25-112b-da7a-6ee8-b046c6a54c18@gmail.com>

Hello Johannes,

On 01/24/2018 09:31 PM, Johannes Thumshirn wrote:
> On Wed, Jan 24, 2018@09:24:42PM +0900, Minwoo Im wrote:
>> It would be convenient to use abort command by a subcommand.
>> This command will strongly used by device developers to test device.
> 
> Ahm... please no.
> 
> If you need it for development just hack a small tool to create the
> passthrough ioctl() call but don't hand out loaded guns to children^Wusers.
> 

Thanks for your kindly comment.

I thought nvme-cli tool would be used mostly by developers, not children 
users. Also thought that it will not need any helps from kernel to abort 
a specified command not just like delete I/O SQ/CQ so that nvme-cli 
could handle this kind of thing.

But, actually there is no limit for anybody to use this interface tool.
I agree what you're saying. So, please skip it.

Thanks,
