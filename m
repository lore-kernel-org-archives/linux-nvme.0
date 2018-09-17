From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 17 Sep 2018 06:41:27 -0700
Subject: [REPOST][PATCH] nvme_fc: add 'nvme_discovery' sysfs attribute to
 fc transport device
In-Reply-To: <c806be1b-f86f-de84-3669-d9bb89aaaf65@gmail.com>
References: <20180820220611.8769-1-jsmart2021@gmail.com>
 <20180911085843.GA17520@infradead.org>
 <c806be1b-f86f-de84-3669-d9bb89aaaf65@gmail.com>
Message-ID: <20180917134127.GA6009@infradead.org>

On Tue, Sep 11, 2018@11:02:13AM -0700, James Smart wrote:
> Well, I don't think I agree with you on the safeness of the locking, but
> moving it to the other style isn't different and looks more normal. I'll
> rework it.

You are iterating the list without the lock and only take the lock
to remove the entry - this is racy vs another thread adding to or
removing from the list.
