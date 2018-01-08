From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 8 Jan 2018 02:05:31 -0800
Subject: [PATCH 13/14] megaraid_sas: NVME passthru command support
In-Reply-To: <1515159339-26790-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1515159339-26790-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Message-ID: <20180108100531.GA6967@infradead.org>

NAK.  Please implement the same ioctl interfaces as the nvme driver
instead of inventing your own incomaptible one.
