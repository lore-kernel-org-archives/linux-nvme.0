From: sagigrim@gmail.com (Sagi Grimberg)
Date: Wed, 8 Jun 2016 16:55:41 +0300
Subject: [PATCH 11/11] nvme-fabrics: pass non-blocking flag to connect
 request allocation
In-Reply-To: <1465389066-19119-12-git-send-email-hch@lst.de>
References: <1465389066-19119-1-git-send-email-hch@lst.de>
 <1465389066-19119-12-git-send-email-hch@lst.de>
Message-ID: <575823DD.8080000@gmail.com>

Looks fine,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

Would be nice to reduce the number of arguments
passed to __nvme_submit_sync_cmd() at some point..
