From: dledford@redhat.com (Doug Ledford)
Date: Fri, 28 Apr 2017 18:48:05 -0400
Subject: [PATCH v2 3/6] RDMA/core: expose affinity mappings per
 completion vector
In-Reply-To: <1491474998-16423-4-git-send-email-sagi@grimberg.me>
References: <1491474998-16423-1-git-send-email-sagi@grimberg.me>
 <1491474998-16423-4-git-send-email-sagi@grimberg.me>
Message-ID: <1493419685.3041.174.camel@redhat.com>

On Thu, 2017-04-06@13:36 +0300, Sagi Grimberg wrote:
> This will allow ULPs to intelligently locate threads based
> on completion vector cpu affinity mappings. In case the
> driver does not expose a get_vector_affinity callout, return
> NULL so the caller can maintain a fallback logic.
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>?

Acked-by: Doug Ledford <dledford at redhat.com>

-- 
Doug Ledford <dledford at redhat.com>
? ? GPG KeyID: B826A3330E572FDD
? ?
Key fingerprint = AE6B 1BDA 122B 23B4 265B ?1274 B826 A333 0E57 2FDD
