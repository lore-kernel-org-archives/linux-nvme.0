From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 21 Jul 2015 02:02:54 -0400
Subject: Data integrity tweaks
In-Reply-To: <20150716091957.GA18310@infradead.org>
References: <20150716091957.GA18310@infradead.org>
Message-ID: <1437458579-18706-1-git-send-email-martin.petersen@oracle.com>

Christoph suggested moving blk_integrity to struct gendisk to overcome
some of the headaches we have wrt. NVMe and metadata. This patch series
aims to simplify the code and to accommodate requirements that didn't
exist when the code was originally conceived.

I have not done a full integrity qual cycle on top of this series so it
is mostly meant as an RFC. Would like to hear if people agree with the
overall approach first.

-- 
Martin K. Petersen	Oracle Linux Engineering
