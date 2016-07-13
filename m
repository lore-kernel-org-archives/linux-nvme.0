From: mlin@kernel.org (Ming Lin)
Date: Wed, 13 Jul 2016 08:01:16 -0700
Subject: [PATCH] nvme-fabrics: get ctrl reference in nvmf_dev_write
In-Reply-To: <005301d1dd15$3e7769c0$bb663d40$@opengridcomputing.com>
References: <1468363122-11073-1-git-send-email-mlin@kernel.org>
 <20160713021831.GA7782@lst.de> <1468392841.23662.5.camel@kernel.org>
 <005301d1dd15$3e7769c0$bb663d40$@opengridcomputing.com>
Message-ID: <CAF1ivSZb1kxbhjyooEG+SptaiCgBCkt4YV35PNemL=F6h_arsA@mail.gmail.com>

On Wed, Jul 13, 2016@7:45 AM, Steve Wise <swise@opengridcomputing.com> wrote:
>
> This change again avoids the first crash, but I still see the __ib_process_cq() crash.
>

Could you post the call stack?
