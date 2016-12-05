From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 5 Dec 2016 19:08:03 +0200
Subject: [PATCH 1/3] nvmet: delete controllers deletion upon subsystem
 release
In-Reply-To: <20161205154039.GC6529@lst.de>
References: <1480936146-6406-1-git-send-email-sagi@grimberg.me>
 <1480936146-6406-2-git-send-email-sagi@grimberg.me>
 <20161205154039.GC6529@lst.de>
Message-ID: <72c13127-830a-e3b1-c10c-6992da0502e8@grimberg.me>


>> No reason for them to be kept around if we are
>> deleting the subsystem, so instead of passively
>> wait for the host to disconnect, actively delete
>> the controllers.
>
> Looks fine, but I'd really love to see a testcase for this in some form..

Should we revive the selftests branch?

>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
>
