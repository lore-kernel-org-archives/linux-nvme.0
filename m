From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 18 May 2017 06:39:36 -0700
Subject: [PATCH] Add a parameter for NVME_IOCTL_ID to get Namespaces ID
In-Reply-To: <bfb905ee-27a4-d39c-8e4d-2511e66292b1@huawei.com>
References: <1495081061-17660-1-git-send-email-zouming.zouming@huawei.com>
 <20170518063808.GA28607@infradead.org>
 <bfb905ee-27a4-d39c-8e4d-2511e66292b1@huawei.com>
Message-ID: <20170518133936.GA30370@infradead.org>

I can't see how it would fail.  But if you're worried about thast case
use the nsid sysfs attribute instead.
