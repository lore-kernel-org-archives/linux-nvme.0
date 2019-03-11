From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 11 Mar 2019 15:28:29 -0700
Subject: [PATCH 2/2 blktests] nvme: test out-of-range I/O access
In-Reply-To: <20190311222127.GD1315@vader>
References: <20190306094643.10262-1-sagi@grimberg.me>
 <20190306094643.10262-2-sagi@grimberg.me> <20190311203523.GA1315@vader>
 <cdf619bc-1fbc-9244-907d-61fcba752730@grimberg.me>
 <20190311222127.GD1315@vader>
Message-ID: <c529a4bb-df72-6a54-9da8-fb4a221bfabf@grimberg.me>


> Do you know which patch fixed it, so I can add a reference to it in the
> test?

commit 9c891c139894ce2ec0ca585a00e0bec5e6b4ccab
Author: Sagi Grimberg <sagi at grimberg.me>
Date:   Wed Jul 11 16:13:04 2018 +0300

     nvmet: check fileio lba range access boundaries

     Fail out-of-bounds with a proper status code.

     Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
     Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
     Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
     Signed-off-by: Christoph Hellwig <hch at lst.de>
