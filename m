From: keith.busch@intel.com (Keith Busch)
Date: Mon, 12 Feb 2018 13:25:19 -0700
Subject: [PATCH 2/3] nvme: fix the deadlock in nvme_update_formats
In-Reply-To: <20180212192009.GE16255@localhost.localdomain>
References: <1518440086-583-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518440086-583-2-git-send-email-jianchao.w.wang@oracle.com>
 <16c23a0c-666c-802e-2b4e-c6a6da6f016b@grimberg.me>
 <20180212192009.GE16255@localhost.localdomain>
Message-ID: <20180212202519.GA20962@localhost.localdomain>

Hi Sagi,

This one is fixing a deadlock in namespace detach. It is still not a
widely supported operation, but becoming more common. While the other two
patches in this series look good for 4.17, I would really recommend this
one for 4.16-rc, and add a Cc to linux-stable for 4.15 too. Sound okay?

Thanks,
Keith
