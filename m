From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 5 Jun 2017 10:45:27 -0700
Subject: [PATCH] nvme: Add support to create and send kobject
 uevents(uevents) when asynchronous events are received.
In-Reply-To: <1496670185-17020-1-git-send-email-zouming.zouming@huawei.com>
References: <1496670185-17020-1-git-send-email-zouming.zouming@huawei.com>
Message-ID: <20170605174527.GB5432@infradead.org>

Keith sent a patch for notifying userspace on AERs a while ago,
but the comments on the patch need to be addressed first.
