From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 2 Jun 2017 00:46:00 -0700
Subject: [PATCH 1/2] nvme-cli: add fields into identify controller data
 structure
In-Reply-To: <1496387899-26012-2-git-send-email-guanjunxiong@huawei.com>
References: <1496387899-26012-1-git-send-email-guanjunxiong@huawei.com>
 <1496387899-26012-2-git-send-email-guanjunxiong@huawei.com>
Message-ID: <20170602074600.GA11424@infradead.org>

Please also add them to the kernel copy of the header so that they
stay in sync.  Except for that his looks fine to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>
