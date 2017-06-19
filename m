From: hch@lst.de (Christoph Hellwig)
Date: Mon, 19 Jun 2017 14:55:31 +0200
Subject: [PATCH rfc 29/30] nvme: add sed-opal ctrl manipulation in
 admin configuration
In-Reply-To: <a13e909c-6f0b-0cb3-18c7-878fcf02b3d5@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-30-git-send-email-sagi@grimberg.me>
 <20170619072220.GF13168@lst.de>
 <a13e909c-6f0b-0cb3-18c7-878fcf02b3d5@grimberg.me>
Message-ID: <20170619125531.GT29061@lst.de>

On Mon, Jun 19, 2017@11:03:36AM +0300, Sagi Grimberg wrote:
>
>> The subject sounds odd and it could use a changelog.  But I'd love to
>> pick this change up ASAP as it's the right thing to do..
>
> How? where would you place it? there is no nvme_configure_admin_queue in
> nvme-core.

Doh.  Yeah, let's keep it where it is.
