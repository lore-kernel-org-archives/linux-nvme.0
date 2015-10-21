From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 21 Oct 2015 00:22:45 -0700
Subject: Simplify block integrity registration v2
In-Reply-To: <1445309132-31824-1-git-send-email-martin.petersen@oracle.com>
References: <yq1fv16gtus.fsf@sermon.lab.mkp.net>
 <1445309132-31824-1-git-send-email-martin.petersen@oracle.com>
Message-ID: <20151021072245.GA12393@infradead.org>

On Mon, Oct 19, 2015@10:45:27PM -0400, Martin K. Petersen wrote:
> Changes since last version:
> 
>  - Patch 2/5: Zero template to prevent problems on SCSI devices w/ ATO=0
>  - Patch 5/5: Add Mike's SoB

Can you post a series that also includes Dan series so that we have one
coherent batch of both?
