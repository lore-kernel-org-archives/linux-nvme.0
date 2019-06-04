From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 4 Jun 2019 09:27:05 -0700
Subject: [PATCH v2] nvme: Fix u32 overflow in the number of namespace list
 calculation
In-Reply-To: <CAJX3CtgdrbaPhFPnR13CT9mAQ8yVRyPFMjbFz01gcNz6G=2T_g@mail.gmail.com>
References: <1559604301-14042-1-git-send-email-jalee@purestorage.com>
 <CAJX3CtgdrbaPhFPnR13CT9mAQ8yVRyPFMjbFz01gcNz6G=2T_g@mail.gmail.com>
Message-ID: <d3d00daa-ae3d-e5e7-2e58-ed395f52af24@grimberg.me>

Applied to 5.2-rc-next with a slight conflict resolution.

Please verify that the patch is fine by you:
http://git.infradead.org/nvme.git/commitdiff/e6c9417f9eeec4587bce5a861cfcda0f02b39464?hp=c8b0ec95a45dfda1360a58458456ded45a42a83e
