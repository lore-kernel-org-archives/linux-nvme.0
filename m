From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 16 Oct 2017 13:34:07 +0300
Subject: [PATCH] nvmet: protect sqhd update by a lock
In-Reply-To: <20171013203800.24125-1-jsmart2021@gmail.com>
References: <20171013203800.24125-1-jsmart2021@gmail.com>
Message-ID: <982bd969-c099-fc6c-9fb5-11884abd8da8@grimberg.me>


> In testing target io in read write mix, we did indeed get into cases
> where sqhd didn't update properly and slowly missed enough updates to
> shutdown the queue.
> 
> Protect the read/modify/set update of sqhd under a lock for coherency.

How does this fix the issue given that updates are not protected?
