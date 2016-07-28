From: roysh@mellanox.com (Roy Shterman)
Date: Fri, 29 Jul 2016 00:04:20 +0300
Subject: [PATCH] Adding hostnqn parameter to connect and discover commands 
Message-ID: <1469739861-32703-1-git-send-email-roysh@mellanox.com>

'hostnqn' is a valid parameter which can be used
when executing connect or discover commands from initiator side but
doesn't have support in nvme-cli tool.

Roy Shterman (1):
  nvme-cli/fabrics: Adding missing parameters to discover and connect

 fabrics.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

-- 
1.7.8.2
