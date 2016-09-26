From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 26 Sep 2016 07:57:51 -0700
Subject: [PATCH 3/3] nvme-fabrics: Move controller id to opts struct
In-Reply-To: <f3b57b6f-245c-536e-3517-a3a995d5e721@broadcom.com>
References: <57e9321a.e6Pgooc71MbSI4hg%james.smart@broadcom.com>
 <20160926144227.GA9792@infradead.org>
 <f3b57b6f-245c-536e-3517-a3a995d5e721@broadcom.com>
Message-ID: <20160926145751.GA767@infradead.org>

Linux will only support dynamic controllers ever.  Static ones are a
horrible idea and were strong armed into the spec at last minute with
bogus claims.
