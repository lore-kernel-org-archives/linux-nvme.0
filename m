From: bvanassche@acm.org (Bart Van Assche)
Date: Thu, 8 Aug 2019 16:26:13 -0700
Subject: [PATCH v3 0/7] nvme controller reset and namespace scan work race
 conditions
In-Reply-To: <20190808205325.24036-1-sagi@grimberg.me>
References: <20190808205325.24036-1-sagi@grimberg.me>
Message-ID: <779b707b-5892-bf23-52d8-5c8affe524b6@acm.org>

On 8/8/19 1:53 PM, Sagi Grimberg wrote:
> for j in `seq 50`; do for i in `seq 50`; do nvme reset /dev/nvme0; done ; nvme disconnect-all; nvme connect-all; done

Has anyone already volunteered to convert this into a patch for the 
blktests project?

Thanks,

Bart.
