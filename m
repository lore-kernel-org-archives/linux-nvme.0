From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 28 Aug 2017 09:32:58 +0300
Subject: [PATCH 05/10] nvme: don't blindly overwrite identifiers on disk
 revalidate
In-Reply-To: <20170828062311.GB913@lst.de>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-6-hch@lst.de>
 <e62a9b05-a02a-1846-6339-84c13248c9ce@grimberg.me>
 <20170828062311.GB913@lst.de>
Message-ID: <826a25fd-d71f-0182-745f-0c9920953c8b@grimberg.me>


>> Shouldn't uuid,nguid,eui64 record the previous values prior to calling
>> nvme_report_ns_ids?
> 
> The previous values are still in the namespace structure, and we use
> the on-stack variables for the current ones.

Of course, misread that one, thanks.
