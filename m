From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 13 Feb 2018 12:46:39 +0200
Subject: [PATCH 1/3] nvme: rename NVME_CTRL_RECONNECTING state to
 NVME_CTRL_CONNECTING
In-Reply-To: <7a611bf2-8a70-1b11-0616-f79531a2cc3d@mellanox.com>
References: <1517416286-31109-1-git-send-email-maxg@mellanox.com>
 <1517416286-31109-2-git-send-email-maxg@mellanox.com>
 <d8241724-ef3a-4946-4629-3598413ca836@grimberg.me>
 <c896305c-90d0-e4aa-d861-ea9ad0076161@grimberg.me>
 <7a611bf2-8a70-1b11-0616-f79531a2cc3d@mellanox.com>
Message-ID: <d6e78772-5345-3a03-b376-5656bfebe606@grimberg.me>

>> Max, I fixed it up locally in nvme-4.16-rc, please verify that its
>> correct and passes your local tests.
> 
> Sagi,
> I guess you applied it after rebasing, I've mentioned that there was 
> still 1 commit missing in nvme-4.16 (your reset fix).

Which one?

> I'll run tests on nvme-4.16-rc and update soon.

Thanks
