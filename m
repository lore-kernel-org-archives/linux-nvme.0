From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 5 Aug 2019 11:12:20 -0700
Subject: [PATCH rfc v2 2/6] nvme: return nvme_error_status for sync
 commands failure
In-Reply-To: <20190804075758.GB14486@minwoo-desktop>
References: <20190803024955.29508-1-sagi@grimberg.me>
 <20190803024955.29508-3-sagi@grimberg.me>
 <20190804075758.GB14486@minwoo-desktop>
Message-ID: <a16aa5b3-262b-e895-e0f2-f28e01c39e4a@grimberg.me>


> Hi Sagi,
> 
> On 19-08-02 19:49:51, Sagi Grimberg wrote:
>> callers should not rely on raw nvme status, blk_status_t
>> is more appropriate.
> 
> May I ask why caller should not rely on the nvme status?

Because the origin of these calls may not be nvme at all, so
a generic block status is definitely more appropriate.
