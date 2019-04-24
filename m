From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 25 Apr 2019 03:05:14 +0900
Subject: [PATCH 2/2] nvme: pci: Do not initialize local_var
In-Reply-To: <fb880f9a-57f6-2916-374d-7e0ccadab3d8@grimberg.me>
References: <20190411155239.1094-1-minwoo.im.dev@gmail.com>
 <20190411155239.1094-3-minwoo.im.dev@gmail.com>
 <fb880f9a-57f6-2916-374d-7e0ccadab3d8@grimberg.me>
Message-ID: <CAA7jztcu-MRnUZOyUMzz_FYHvqaB-c8WEAR49MAFGGapk5iGLQ@mail.gmail.com>

On Thu, Apr 25, 2019@1:32 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
> > Variable "n" will be assigned once kstrtoint() succeeds, otherwise it
> > will not be referred because kstrtoint() will return an error which
> > means go out from this function.
>
> Makes sense, but did you verify that static checkers don't complain on
> this?

Thanks for your comment on this. I didn't check static-check for this code,
by the way. If it needs to be done, I'll do it right away.

Thanks,
