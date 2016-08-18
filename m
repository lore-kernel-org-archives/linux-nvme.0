From: sergey.senozhatsky.work@gmail.com (Sergey Senozhatsky)
Date: Thu, 18 Aug 2016 11:36:33 +0900
Subject: [PATCH 15/15] block: Add FIXME comment to handle device_add_disk
 error
In-Reply-To: <1471418115-3654-16-git-send-email-famz@redhat.com>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
 <1471418115-3654-16-git-send-email-famz@redhat.com>
Message-ID: <20160818023633.GC500@swordfish>

On (08/17/16 15:15), Fam Zheng wrote:
[..]
>   (
>     rc = device_add_disk(e1, e2, e3);
>   |
>   + /* FIXME: handle error. */
>     device_add_disk(e1, e2, e3);

or use __must_check for device_add_disk() function?
/* which is _attribute__((warn_unused_result)) */

	-ss
