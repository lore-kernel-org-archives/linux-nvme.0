From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 8 Feb 2017 11:43:23 +0200
Subject: [PATCH] nvmet: Do not check for sg_cnt being zero for read/write
 commands.
In-Reply-To: <20170208082426.GA7629@lst.de>
References: <1486510557-26831-1-git-send-email-parav@mellanox.com>
 <20170208082426.GA7629@lst.de>
Message-ID: <eb2c9d8b-ead6-8472-1f3a-9f91ca5cb0de@grimberg.me>


> Except that we currently don't verify the data transfer in the SGL
> matches that in the command.  It's been on my todo list for a while,
> so maybe you can take it off my plate first before we'll aply this
> patch.

Any reason not to take it as is and add the sgl validity check
incrementally?
