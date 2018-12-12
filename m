From: hch@lst.de (Christoph Hellwig)
Date: Wed, 12 Dec 2018 08:37:56 +0100
Subject: [PATCH RFC 4/4] nvme-multipath: disable polling for underlying
 namespace request queue
In-Reply-To: <f134d4e7-5d0e-7345-0414-9aa3524c75e9@grimberg.me>
References: <20181211233652.9705-1-sagi@grimberg.me>
 <20181211233652.9705-5-sagi@grimberg.me> <20181212071140.GD28461@lst.de>
 <d0d76a09-7ec9-2018-d4ce-7a08d4ab4002@grimberg.me>
 <20181212072132.GA28850@lst.de>
 <f134d4e7-5d0e-7345-0414-9aa3524c75e9@grimberg.me>
Message-ID: <20181212073756.GB29091@lst.de>

On Tue, Dec 11, 2018@11:29:33PM -0800, Sagi Grimberg wrote:
> Yea I agree.. Would probably make better sense to forbid it in the core,
> but I'm not entirely sure how this is possible make_request drivers...

Either we can clear the flag in generic_make_request when QUEUE_FLAG_POLL
is not set, or just change the few users to never even set it in that
case.
