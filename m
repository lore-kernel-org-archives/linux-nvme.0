From: keith.busch@linux.intel.com (Keith Busch)
Date: Mon, 2 Jul 2018 09:45:15 -0600
Subject: [PATCH 1/2] nvme-pci: remove whitespace
In-Reply-To: <aaa460e43cb43efbfb902d0aa844a1da9ed270dc.1530457943.git.zhangweiping@didichuxing.com>
References: <cover.1530457943.git.zhangweiping@didichuxing.com>
 <aaa460e43cb43efbfb902d0aa844a1da9ed270dc.1530457943.git.zhangweiping@didichuxing.com>
Message-ID: <20180702154515.GA22877@localhost.localdomain>

These style changes aren't the sort of cleanups we need. For one, there's
nothing wrong with how it already exists, and it has been this particular
style since the driver's inclusion; there are lots of other places in
the driver using this pattern. More importantly, it creates inconvenient
stable porting issues for developers doing real work in these areas.
