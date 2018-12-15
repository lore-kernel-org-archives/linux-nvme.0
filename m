From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 14 Dec 2018 18:13:50 -0800
Subject: [PATCH] nvme-rdma: fix timeout handler
In-Reply-To: <20181215014059.GA28629@xldev1604-tmpl.dev.purestorage.com>
References: <20181213212917.8900-1-sagi@grimberg.me>
 <fa19e6a2-e358-6e29-53c7-4a68eacf6a93@grimberg.me>
 <20181215014059.GA28629@xldev1604-tmpl.dev.purestorage.com>
Message-ID: <e63e0427-0bde-dd13-1fbf-29443b9f1ee2@grimberg.me>


> I have tested the code (backported to v4.19.9) and verified it works great for the scenarios I had originally reported. Also the code looks good to me.

Thanks Jaesoo,

Now I'd like to hear from Christoph and Keith, are we ok with the 
proposed approach that we are poking into the request state?
