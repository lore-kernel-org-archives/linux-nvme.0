From: hch@lst.de (Christoph Hellwig)
Date: Fri, 26 Jan 2018 10:18:57 +0100
Subject: [PATCH v8 0/2] add tracepoints for nvme command submission and
 completion
In-Reply-To: <20180126091629.31829-1-jthumshirn@suse.de>
References: <20180126091629.31829-1-jthumshirn@suse.de>
Message-ID: <20180126091857.GA3888@lst.de>

Still gives lots of warnings:

make -j4 C=2 SUBDIRS=drivers/nvme 2>err.log
drivers/nvme/host/./trace.h:78:1: warning: cast to restricted __le64
drivers/nvme/host/./trace.h:78:1: warning: cast to restricted __le64
drivers/nvme/host/./trace.h:78:1: warning: restricted __le64 degrades to integer
drivers/nvme/host/./trace.h:78:1: warning: restricted __le64 degrades to integer
drivers/nvme/host/./trace.h:78:1: warning: cast to restricted __le32
drivers/nvme/host/./trace.h:78:1: warning: cast to restricted __le32
drivers/nvme/host/./trace.h:78:1: warning: restricted __le32 degrades to integer
drivers/nvme/host/./trace.h:78:1: warning: restricted __le32 degrades to integer
drivers/nvme/host/./trace.h:104:1: warning: cast to restricted __le32
drivers/nvme/host/./trace.h:104:1: warning: cast to restricted __le32
drivers/nvme/host/./trace.h:104:1: warning: restricted __le32 degrades to integer
drivers/nvme/host/./trace.h:104:1: warning: restricted __le32 degrades to integer
drivers/nvme/host/./trace.h:104:1: warning: cast to restricted __le64
drivers/nvme/host/./trace.h:104:1: warning: cast to restricted __le64
drivers/nvme/host/./trace.h:104:1: warning: restricted __le64 degrades to integer
drivers/nvme/host/./trace.h:104:1: warning: restricted __le64 degrades to integer
drivers/nvme/host/./trace.h:104:1: warning: cast to restricted __le32
drivers/nvme/host/./trace.h:104:1: warning: cast to restricted __le32
drivers/nvme/host/./trace.h:104:1: warning: restricted __le32 degrades to integer
drivers/nvme/host/./trace.h:104:1: warning: restricted __le32 degrades to integer
drivers/nvme/host/./trace.h:133:1: warning: cast to restricted __le64
drivers/nvme/host/./trace.h:133:1: warning: cast to restricted __le64
drivers/nvme/host/./trace.h:133:1: warning: restricted __le64 degrades to integer
drivers/nvme/host/./trace.h:133:1: warning: restricted __le64 degrades to integer
