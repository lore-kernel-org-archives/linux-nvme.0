From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Jun 2017 11:03:36 +0300
Subject: [PATCH rfc 29/30] nvme: add sed-opal ctrl manipulation in admin
 configuration
In-Reply-To: <20170619072220.GF13168@lst.de>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-30-git-send-email-sagi@grimberg.me>
 <20170619072220.GF13168@lst.de>
Message-ID: <a13e909c-6f0b-0cb3-18c7-878fcf02b3d5@grimberg.me>


> The subject sounds odd and it could use a changelog.  But I'd love to
> pick this change up ASAP as it's the right thing to do..

How? where would you place it? there is no nvme_configure_admin_queue in
nvme-core.

I suppose we could get it in nvme_init_ctrl?
