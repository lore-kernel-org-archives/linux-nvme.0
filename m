From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 9 Apr 2017 15:28:01 +0300
Subject: [PATCH v2] nvme_fc: avoid double kfree(), don't call
 nvme_cleanup_cmd() in nvme_fc_unmap_data()
In-Reply-To: <1491497276-15944-1-git-send-email-emilne@redhat.com>
References: <1491497276-15944-1-git-send-email-emilne@redhat.com>
Message-ID: <d10fad01-ccf2-04ce-b902-8e3c2ae3da44@grimberg.me>

Reviewed-by: Sagi Grimberg <sagi at grimbeg.me>
