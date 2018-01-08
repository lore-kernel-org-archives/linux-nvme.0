From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 9 Jan 2018 00:51:11 +0900
Subject: [PATCH 1/2] nvme: Take refcount on transport module when using
 block device operations
In-Reply-To: <1515081374-22328-1-git-send-email-maxg@mellanox.com>
References: <1515081374-22328-1-git-send-email-maxg@mellanox.com>
Message-ID: <CAA7jzte5xvqtN44C8TsLNnymQ6v3_9O+TMBsA7VbD9DrWU5Nnw@mail.gmail.com>

Hi Max,

On Fri, Jan 5, 2018@12:56 AM, Max Gurtovoy <maxg@mellanox.com> wrote:
> +       kref_put(&ns->kref, nvme_free_ns);

This seems identical to nvme_put_ns(ns);
It would look better if replaced with nvme_put_ns() function call just
like nvme_release()
that you have updated in this patch.

Thanks,
