From: hch@lst.de (Christoph Hellwig)
Date: Wed, 8 Feb 2017 12:54:30 +0100
Subject: [PATCH] nvmet: Do not check for sg_cnt being zero for
 read/write commands.
In-Reply-To: <eb2c9d8b-ead6-8472-1f3a-9f91ca5cb0de@grimberg.me>
References: <1486510557-26831-1-git-send-email-parav@mellanox.com>
 <20170208082426.GA7629@lst.de>
 <eb2c9d8b-ead6-8472-1f3a-9f91ca5cb0de@grimberg.me>
Message-ID: <20170208115430.GA11342@lst.de>

On Wed, Feb 08, 2017@11:43:23AM +0200, Sagi Grimberg wrote:
>
>> Except that we currently don't verify the data transfer in the SGL
>> matches that in the command.  It's been on my todo list for a while,
>> so maybe you can take it off my plate first before we'll aply this
>> patch.
>
> Any reason not to take it as is and add the sgl validity check
> incrementally?

Because that would allow a bad actor host to crash the target easily.
