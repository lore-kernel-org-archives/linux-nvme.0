From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 1 Jun 2019 11:45:27 +0900
Subject: [PATCH 0/3] nvme: Improve processing paused support
In-Reply-To: <76f0ba18-fb80-7a96-6f53-d4df1d637da5@grimberg.me>
References: <20190524202036.17265-1-keith.busch@intel.com>
 <76f0ba18-fb80-7a96-6f53-d4df1d637da5@grimberg.me>
Message-ID: <20190601024525.GB3349@minwooim-desktop>

On 19-05-31 16:32:24, Sagi Grimberg wrote:
> This looks sensible to me,
> 
> Minwoo, do you have any concerns or feedback? If not
> can I get your review tag?

Actually this series are looking good to me.  But, I was just
concerning that if there is better print statement or safe access method
for CSTS.PP bit in the code.

But, the print message is not that critical so that I can make my review
on this.  I need to ask Keith about accessing CSTS.PP without seeing
CC.EN can be valid in some cases, by the way :).

For this series:

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
