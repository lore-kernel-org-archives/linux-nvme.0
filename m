From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 28 Sep 2018 15:41:08 -0700
Subject: [PATCH 1/2 for-4.19] nvmet: handle bio allocation failure
In-Reply-To: <20180928151618.GA8079@lst.de>
References: <20180928004056.22968-1-sagi@grimberg.me>
 <20180928151618.GA8079@lst.de>
Message-ID: <9c3d4fbb-3e64-98a9-36f2-b3d925bc582c@grimberg.me>


>> We cannot rely on bio_alloc to succeed,
> 
> Yes, we can (unless it is an atomic allocation or it exceeds
> BIO_MAX_PAGES, neither of which we do here).

Yea I see that now... lets drop this one...
