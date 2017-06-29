From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Wed, 28 Jun 2017 19:19:24 -0700
Subject: nvme-cli : Sanitize and Sanitize Log command support. 
Message-ID: <20170629021928.19389-1-chaitanya.kulkarni@hgst.com>

HI,

This adds Sanitize and Sanitize-Log command support for nvme-cli. These four patches include command implementation, documentation, status codes and opcodes for the overall sanitize implementation.

For sanitize command specific option I've tested "-a <action>, --sanact=<action>" for block erase sanitize, overwrite sanitize on a real device, rest of the code I've added for the completeness.

Regards,
Chaitanya
