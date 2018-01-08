From: hch@lst.de (Christoph Hellwig)
Date: Mon, 8 Jan 2018 16:56:50 +0100
Subject: [PATCH 1/2] nvme: Take refcount on transport module when using
 block device operations
In-Reply-To: <CAA7jzte5xvqtN44C8TsLNnymQ6v3_9O+TMBsA7VbD9DrWU5Nnw@mail.gmail.com>
References: <1515081374-22328-1-git-send-email-maxg@mellanox.com>
 <CAA7jzte5xvqtN44C8TsLNnymQ6v3_9O+TMBsA7VbD9DrWU5Nnw@mail.gmail.com>
Message-ID: <20180108155650.GA12142@lst.de>

On Tue, Jan 09, 2018@12:51:11AM +0900, Minwoo Im wrote:
> Hi Max,
> 
> On Fri, Jan 5, 2018@12:56 AM, Max Gurtovoy <maxg@mellanox.com> wrote:
> > +       kref_put(&ns->kref, nvme_free_ns);
> 
> This seems identical to nvme_put_ns(ns);
> It would look better if replaced with nvme_put_ns() function call just
> like nvme_release()
> that you have updated in this patch.

I've fixed it in the applied patch, thanks!
