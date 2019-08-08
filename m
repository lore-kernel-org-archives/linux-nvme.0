From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 8 Aug 2019 16:33:56 -0700
Subject: [PATCH v3 0/7] nvme controller reset and namespace scan work race
 conditions
In-Reply-To: <779b707b-5892-bf23-52d8-5c8affe524b6@acm.org>
References: <20190808205325.24036-1-sagi@grimberg.me>
 <779b707b-5892-bf23-52d8-5c8affe524b6@acm.org>
Message-ID: <32b4c64f-4565-5a1c-269e-9a9059570e99@grimberg.me>


>> for j in `seq 50`; do for i in `seq 50`; do nvme reset /dev/nvme0; 
>> done ; nvme disconnect-all; nvme connect-all; done
> 
> Has anyone already volunteered to convert this into a patch for the 
> blktests project?

I'll see if it can reliably reproduce it for loop. Or perhaps I can
run this with tcp on 127.0.0.1?
