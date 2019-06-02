From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 2 Jun 2019 00:32:43 -0700
Subject: [PATCH] nvmet: fix data_len to 0 for bdev-backed write_zeroes
In-Reply-To: <20190602034339.11246-1-minwoo.im.dev@gmail.com>
References: <20190602034339.11246-1-minwoo.im.dev@gmail.com>
Message-ID: <69cfebd4-1e32-b86e-b02d-a92566f9d2db@grimberg.me>

Is this a regression? IIRC write-zeros used to work...
