From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun,  7 Aug 2016 15:19:21 +0300
Subject: [PATCH nvme-cli 0/4] Some useful fabrics patches
Message-ID: <1470572365-20674-1-git-send-email-sagi@grimberg.me>

Hey Keith,

So here are some useful fabrics patches I had in the pipe.
The first allows for ipv6 address resolution (resend) as
we will support it in fabrics for 4.9.

Patch 2 makes the discover output nice and pretty by outputing
human readable strings instead of numeric values.

Patch 3 just removes a redundant call.

Patch 4 is rfc, This was for my own convenience being too
lazy for manual parameterizing when discovering/connecting to nvmf
targets so this should allow to parameterize in a conf file.
Not sure if you are fond of the approach so I'd love to see some feedback.

Sagi Grimberg (4):
  fabrics: Allow ipv6 address resolution
  fabrics: stringify discover output.
  fabrics: Remove redundant build_options
  fabrics: Allow discover params to come from a conf file

 fabrics.c | 175 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 158 insertions(+), 17 deletions(-)

-- 
1.9.1
