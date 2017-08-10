From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 10 Aug 2017 11:08:33 +0200
Subject: [PATCH 2/2] lpfc: support nvmet_fc defer_rcv callback
In-Reply-To: <20170801221240.31723-3-jsmart2021@gmail.com>
References: <20170801221240.31723-1-jsmart2021@gmail.com>
 <20170801221240.31723-3-jsmart2021@gmail.com>
Message-ID: <20170810090833.dwxelipklkvy3c6u@infradead.org>

Applied to nvme-4.13 with the void casts removed, but the strings left
as the surrounding code.
