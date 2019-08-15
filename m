From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 15 Aug 2019 10:10:59 -0700
Subject: [PATCH] nvme: exclude completion trace from non-multipath builds
In-Reply-To: <1febf497-e92e-6acd-1968-50ae7735ec79@grimberg.me>
References: <9efc495c41b7bf050362a3a7eb64b5809092afd6.1565280170.git.mskorzhinskiy@solarflare.com>
 <1febf497-e92e-6acd-1968-50ae7735ec79@grimberg.me>
Message-ID: <a83f9206-4e09-3522-8574-1f9887491e2a@grimberg.me>


> The call should not condition on CONFIG_NVME_MULTIPATH, but the function
> implementation should be left empty if CONFIG_NVME_MULTIPATH is not
> enabled (see nvme.h).
> 
> Also, lets call it nvme_trace_bio_complete..

Hey Mikhail, are you sending a respin or should I?
