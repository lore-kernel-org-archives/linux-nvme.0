From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 29 Jan 2018 21:40:25 +0200
Subject: [PATCH v2 1/1] nvme: Add fault injection feature
In-Reply-To: <83db72d9-9990-fd68-f625-62bc702d8518@oracle.com>
References: <1516825390-3324-1-git-send-email-thomas.tai@oracle.com>
 <1516825390-3324-2-git-send-email-thomas.tai@oracle.com>
 <e3a91c4c-b63e-24a2-63f1-d873fbc63e9c@grimberg.me>
 <83db72d9-9990-fd68-f625-62bc702d8518@oracle.com>
Message-ID: <07a7d8be-e719-e603-da1c-6ecaff6b0d15@grimberg.me>


> Hi Sagi,
> Would you be more specific about the multipathing setting?

Every retry-able status code would trigger path-failover (see
nvme_error_status).
