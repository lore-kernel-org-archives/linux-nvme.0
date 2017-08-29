From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 29 Aug 2017 01:32:00 -0700
Subject: [PATCH] nvmet: Add support for HOST_ID feature.
In-Reply-To: <9f119f3b-cca9-7c6e-64ff-53bd24249de3@grimberg.me>
References: <1503922057-1141-1-git-send-email-omri@excelero.com>
 <859a5a5d-9aa1-44e6-7d67-42fed0339a8b@grimberg.me>
 <A5F28D4A728A7E41839CDC5C3B5A01E8872735FF@FMSMSX103.amr.corp.intel.com>
 <9f119f3b-cca9-7c6e-64ff-53bd24249de3@grimberg.me>
Message-ID: <20170829083200.GA30908@infradead.org>

On Mon, Aug 28, 2017@11:15:57PM +0300, Sagi Grimberg wrote:
> That's true, We should work with uuid_t for hostids. thanks Daniel.

And we already do on the host side, it's just that the target didn't
need to parse it yet.
