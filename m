From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Jun 2017 11:06:23 +0300
Subject: [PATCH v2 1/2] nvme-core: change commas to semicolons in
 nvme_get_log_page
In-Reply-To: <20170619065926.GB12938@lst.de>
References: <1497791759-5754-1-git-send-email-sagi@grimberg.me>
 <20170619065926.GB12938@lst.de>
Message-ID: <0d524318-21d0-ee92-9286-7771f0ed7fdb@grimberg.me>


> This looks ok, but I think it's just too much churn at the moment.
> We already have one patch that moves it to scsi.c as part of the
> fw activation without reset patchset, and we if the scsi emulation
> removal goes in it should just go away entirely..

OK, we can discard it then...
