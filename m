From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 23:46:04 -0800
Subject: [PATCH 1/2] nvme: Introduce nvme_is_aen_req function
In-Reply-To: <20181212065501.21580-1-nitzanc@mellanox.com>
References: <20181212065501.21580-1-nitzanc@mellanox.com>
Message-ID: <1e347e83-1f06-3e43-7dfe-fe7b0e6f264f@grimberg.me>

Don't really see the point of this wrapper... But if
you are going to introduce it, you need to have others
use it as well...
